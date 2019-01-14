# XVRQT Homepage
Simple, static homepage for the xvrqt.com root domain.

Includes the home pages and a 404 page.

**Upstreamm:** https://git.xvrqt.com/amy/typescript-web-app-template

## Demo
[https://web-starter.xvrqt.com](https://web-starter.xvrqt.com)

## Quick Start
1. Clone the repositiory: `git clone git@git.xvrqt.com:xvrqt/homepage.git`
2. Install the dependencies: `npm install`
3. Start the dev container: `docker-compose up ts-web-app-dev` **OR** Start an Express server: `npm run serve local`
4. Open a browser, and navigate to: `http://localhost:8080`
5. Make a change to a file in `src/` your changes should be reflected immediately in the browser.
6. Build your web app/site!
7. Create a production ready container: `docker-compose up ts-web-app`
8. Navigate to: `http://localhost`

## Deploying
Any commit to master deploys to [staging](https://stg.xvrqt.com). 

Any tagged commit can be mannually deployed to [production](https://xvrqt.com).
