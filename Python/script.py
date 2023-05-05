import requests
import sys

# Accept the programming language as a command-line argument
if len(sys.argv) != 2:
    print("Usage: python script.py <programming_language>")
    sys.exit(1)

language = sys.argv[1]

# Authenticate with the GitHub API using a personal access token
# Replace <ACCESS_TOKEN> with your actual token
headers = {"Authorization": "Bearer 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 "}

# Fetch a list of repositories on GitHub that match the provided programming language and are sorted by the number of stars in descending order
url = f"https://api.github.com/search/repositories?q=language:{language}&sort=stars&order=desc"
response = requests.get(url, headers=headers)

if response.status_code != 200:
    print(f"Error fetching repositories (status code {response.status_code})")
    sys.exit(1)

repositories = response.json()["items"]

# Print the names and descriptions of the top 10 repositories
for repo in repositories[:10]:
    name = repo["name"]
    description = repo["description"] or "No description available"
    print(f"{name}: {description}")