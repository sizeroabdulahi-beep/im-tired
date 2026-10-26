mkdir -p tradepro && cd tradepro && bash <<'TRADEPRO_EOF'

# Create folders
mkdir -p api server/middleware server/services server/routes prisma public/css public/js

# ───────────── ROOT ─────────────
cat > vercel.json <<'EOF'
{
  "buildCommand": "npx prisma generate",
  "outputDirectory": "public",
  "rewrites": [
    { "source": "/api/(.*)", "destination": "/api/index.js" }
  ]
}
EOF

cat > package.json <<'EOF'
{
  "name": "tradepro",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "node server/server.js",
    "start": "node server/server.js",
    "seed": "node prisma/seed.js",
    "postinstall": "prisma generate",
    "migrate": "prisma migrate deploy"
  },
  "dependencies": {
    "@prisma/client": "^5.22.0",
    "argon2": "^0.41.1",
    "cookie-parser": "^1.4.7",
    "cors": "^2.8.5",
    "dotenv": "^16.4.5",
    "express": "^4.21.1",
    "express-rate-limit": "^7.4.1",
    "helmet": "^8.0.0",
    "jsonwebtoken": "^9.0.2",
    "zod": "^3.23.8"
  },
  "devDependencies": { "prisma": "^5.22.0" }
}
EOF

cat > .gitignore <<'EOF'
node_modules
.env
.env.local
.vercel
*.log
EOF

cat > .env.example <<'EOF'
DATABASE_URL=postgresql://user:pass@host:5432/db
JWT_SECRET=change-me-to-32-char-random-string
NODE_ENV=development
DEMO_MODE=true
PORT=3000
EOF

cat > README.md <<'EOF'
# TradePro

Demo crypto trading platform. All money simulated.

## Local
