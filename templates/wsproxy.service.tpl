[Unit]
Description=SSHPLUS AutoBot WebSocket Proxy
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/opt/sshplus-autombot/bin/start-wsproxy.sh
Restart=always
RestartSec=3
WorkingDirectory=/opt/sshplus-autombot
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target