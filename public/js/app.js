// Main Application Logic

// Initialize the application
document.addEventListener('DOMContentLoaded', () => {
    initializeApp();
});

function initializeApp() {
    // Setup navigation toggle for mobile
    setupMobileNav();
    
    // Setup tab functionality
    setupTabs();
    
    // Setup navbar scroll effect
    setupNavbarScroll();
    
    // Register all routes
    registerRoutes();
    
    // Initialize router
    router.handleRoute();
}

// Mobile Navigation Toggle
function setupMobileNav() {
    const navToggle = document.getElementById('navToggle');
    const navMenu = document.getElementById('navMenu');
    
    if (navToggle && navMenu) {
        navToggle.addEventListener('click', () => {
            navMenu.classList.toggle('active');
            navToggle.classList.toggle('active');
        });
        
        // Close menu when clicking on a link
        const navLinks = navMenu.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            link.addEventListener('click', () => {
                navMenu.classList.remove('active');
                navToggle.classList.remove('active');
            });
        });
    }
}

// Tab Functionality
function setupTabs() {
    document.addEventListener('click', (e) => {
        if (e.target.classList.contains('tab-button')) {
            const tabName = e.target.getAttribute('data-tab');
            const tabContainer = e.target.closest('.tabs');
            
            if (tabContainer) {
                // Remove active class from all buttons and contents
                tabContainer.querySelectorAll('.tab-button').forEach(btn => {
                    btn.classList.remove('active');
                });
                tabContainer.querySelectorAll('.tab-content').forEach(content => {
                    content.classList.remove('active');
                });
                
                // Add active class to clicked button and corresponding content
                e.target.classList.add('active');
                const activeContent = tabContainer.querySelector(`#${tabName}`);
                if (activeContent) {
                    activeContent.classList.add('active');
                }
            }
        }
    });
}

// Navbar Scroll Effect
function setupNavbarScroll() {
    const navbar = document.querySelector('.navbar');
    
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
}

// Register all application routes
function registerRoutes() {
    // Home page
    router.register('home', () => {
        renderPage(components.home());
    });
    
    // Virtual Machines page
    router.register('virtual-machines', () => {
        renderPage(components.virtualMachines());
    });
    
    // Containers page
    router.register('containers', () => {
        renderPage(components.containers());
    });
    
    // Bare Metal page
    router.register('bare-metal', () => {
        renderPage(components.bareMetal());
    });
    
    // Confidential Compute page
    router.register('confidential-compute', () => {
        renderPage(components.confidentialCompute());
    });
    
    // Clusters page
    router.register('clusters', () => {
        renderPage(components.clusters());
    });
    
    // Pricing page
    router.register('pricing', () => {
        renderPage(components.pricing());
    });
}

// Render page content
function renderPage(content) {
    const app = document.getElementById('app');
    if (app) {
        app.innerHTML = content;
        
        // Re-initialize tabs after rendering new content
        setupTabs();
        
        // Add fade-in animation to sections
        const sections = app.querySelectorAll('.section');
        sections.forEach((section, index) => {
            setTimeout(() => {
                section.classList.add('fade-in');
            }, index * 100);
        });
    }
}

// Utility function to format numbers
function formatNumber(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

// Utility function to format currency
function formatCurrency(amount) {
    return `$${formatNumber(amount)}`;
}

// Export utilities if needed
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        formatNumber,
        formatCurrency
    };
}
