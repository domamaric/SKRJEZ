import urllib.request
import re
import sys


def fetch_page(url):
    try:
        with urllib.request.urlopen(url) as response:
            return response.read().decode("utf8")
    except Exception as e:
        print(f"Pogreska pri dohvacanju stranice {url}: {e}")
        exit(1)

def extract_urls(page_content):
    urls = re.findall(r'href="(https?://.*?)"', page_content)
    return urls

def extract_hosts(urls):
    hosts = {}
    for url in urls:
        match = re.match(r"https?://(www\.)?(.*?)(/.*|$)", url)
        if match:
            host = match.group(2)
            hosts[host] = hosts.get(host, 0) + 1
    return hosts

def print_hosts(hosts):
    print("\nHostovi i njihov broj referenciranja:\n" + "="*55)
    for host, count in hosts.items():
        print(f"{host:<50} {count}")

def extract_emails(page_content):
    emails = set(re.findall(r"([a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+)", page_content))
    return emails

def print_emails(emails):
    print("\nEmail adrese na toj stranici:\n" + "="*55)
    for email in emails:
        print(email)

def count_images(page_content):
    return len(re.findall(r'<img.*?>', page_content))

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Koristenje: python zadatak4.py <url>")
        exit(1)

    url = sys.argv[1]
    page_content = fetch_page(url)

    urls = extract_urls(page_content)
    print("Linkovi na sve druge stranice:\n" + "="*55)
    for url in urls:
        print(url)

    hosts = extract_hosts(urls)
    print_hosts(hosts)

    emails = extract_emails(page_content)
    print_emails(emails)

    image_count = count_images(page_content)
    print(f"\nBroj linkova na slike: {image_count}")
