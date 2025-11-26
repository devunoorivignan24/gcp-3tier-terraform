#!/bin/bash

# Update and install nginx
apt update -y
apt install -y nginx

# Create the HTML file
cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GCP 3-Tier DevOps Project</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            text-align: center;
            padding: 50px;
        }
        h1 {
            color: #1a73e8;
        }
        .box {
            background: white;
            margin: auto;
            padding: 25px;
            max-width: 500px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
        }
        .hostname {
            margin-top: 20px;
            font-weight: bold;
            color: #34a853;
            font-size: 20px;
        }
    </style>
</head>
<body>
    <div class="box">
        <h1>Welcome to My GCP DevOps Project</h1>
        <p>This app is served from a VM inside a Managed Instance Group (MIG).</p>
        <p>Load Balancer → MIG → VM → Cloud SQL</p>

        <div class="hostname">
            Hostname: <span id="hostname"></span>
        </div>
    </div>

    <script>
        fetch('/hostname')
            .then(response => response.text())
            .then(data => document.getElementById('hostname').innerText = data);
    </script>
</body>
</html>
EOF

# Create an endpoint to show VM hostname
echo "server {
    listen 80;
    root /var/www/html;
    index index.html;

    location /hostname {
        default_type text/plain;
        return 200 \"$(hostname)\";
    }
}" > /etc/nginx/sites-enabled/default

# Restart nginx
systemctl restart nginx
