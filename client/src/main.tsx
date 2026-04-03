import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.tsx'
import { BrowserRouter } from 'react-router-dom';
import { AuthProvider } from './components/Auth/AuthProvider.tsx';

const setFaviconToPvfMark = () => {
  const svg = `
    <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
      <defs>
        <linearGradient id="g" x1="12" y1="10" x2="54" y2="54" gradientUnits="userSpaceOnUse">
          <stop offset="0" stop-color="#7c3aed" />
          <stop offset="1" stop-color="#6366f1" />
        </linearGradient>
        <radialGradient id="h" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(18 14) rotate(45) scale(44 44)">
          <stop offset="0" stop-color="#ffffff" stop-opacity="0.55" />
          <stop offset="1" stop-color="#ffffff" stop-opacity="0" />
        </radialGradient>
      </defs>
      <rect x="4" y="4" width="56" height="56" rx="16" fill="url(#g)" />
      <rect x="4" y="4" width="56" height="56" rx="16" fill="url(#h)" />
      <rect x="4" y="4" width="56" height="56" rx="16" fill="none" stroke="#ffffff" stroke-opacity="0.25" stroke-width="2" />
      <text x="32" y="39" text-anchor="middle"
        font-family="system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif"
        font-size="20" font-weight="800" letter-spacing="1"
        fill="#ffffff">PVF</text>
    </svg>
  `.trim()

  const href = `data:image/svg+xml,${encodeURIComponent(svg)}`

  const existing =
    document.querySelector<HTMLLinkElement>('link[rel="icon"]') ??
    document.querySelector<HTMLLinkElement>('link[rel="shortcut icon"]')

  const link = existing ?? document.createElement('link')
  link.rel = 'icon'
  link.type = 'image/svg+xml'
  link.href = href
  if (!existing) document.head.appendChild(link)
}

setFaviconToPvfMark()

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <AuthProvider>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </AuthProvider>
  </StrictMode>,
)
