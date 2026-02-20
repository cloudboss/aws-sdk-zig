#!/bin/bash
set -euo pipefail

CERT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$CERT_DIR"

# Skip if certificates already exist and are not expired
if [[ -f ca.crt && -f server.crt ]]; then
    if openssl x509 -checkend 86400 -noout -in server.crt 2>/dev/null; then
        echo "Certificates are still valid, skipping generation."
        exit 0
    fi
fi

echo "Generating test CA..."
openssl genrsa -out ca.key 4096 2>/dev/null
openssl req -new -x509 -days 365 -key ca.key -out ca.crt \
    -subj "/CN=AWS SDK Zig Test CA" 2>/dev/null

echo "Generating server certificate..."
openssl genrsa -out server.key 2048 2>/dev/null
openssl req -new -key server.key -out server.csr \
    -subj "/CN=amazonaws.com" 2>/dev/null

cat > server.ext << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = *.amazonaws.com
DNS.2 = *.us-east-1.amazonaws.com
DNS.3 = *.us-west-2.amazonaws.com
DNS.4 = localhost
DNS.5 = endpoint.test
IP.1 = 127.0.0.1
EOF

openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key \
    -CAcreateserial -out server.crt -days 365 \
    -extfile server.ext 2>/dev/null

# Create combined PEM file (cert + key) for LocalStack 4.x
cat server.crt server.key > server.pem

# Clean up intermediate files
rm -f server.csr server.ext ca.srl

echo "Certificates generated in ${CERT_DIR}/"
echo "  CA:     ca.crt, ca.key"
echo "  Server: server.crt, server.key, server.pem"
