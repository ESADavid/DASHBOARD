// Simple SPA Router
class Router {
    constructor() {
        this.routes = {};
        this.currentRoute = null;
        
        // Listen for hash changes
        window.addEventListener('hashchange', () => this.handleRoute());
        window.addEventListener('load', () => this.handleRoute());
    }
    
    // Register a route
    register(path, handler) {
        this.routes[path] = handler;
    }
    
    // Handle route changes
    handleRoute() {
        const hash = window.location.hash.slice(1) || 'home';
        const route = this.routes[hash];
        
        if (route) {
            this.currentRoute = hash;
            route();
            this.updateActiveNav();
            window.scrollTo(0, 0);
        } else {
            // Default to home if route not found
            window.location.hash = '#home';
        }
    }
    
    // Update active navigation link
    updateActiveNav() {
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            const href = link.getAttribute('href');
            if (href === `#${this.currentRoute}`) {
                link.classList.add('active');
            } else {
                link.classList.remove('active');
            }
        });
    }
    
    // Navigate to a route programmatically
    navigate(path) {
        window.location.hash = `#${path}`;
    }
}

// Create global router instance
const router = new Router();
