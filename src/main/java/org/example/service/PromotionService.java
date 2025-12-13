package org.example.service;

import org.example.model.Promotion;
import org.example.repository.PromotionRepository;

import java.util.Date;
import java.util.List;

public class PromotionService {
    private final PromotionRepository promotionRepository;

    public PromotionService() {
        this.promotionRepository = new PromotionRepository();
    }

    // Get all promotions
    public List<Promotion> getAllPromotions() {
        return promotionRepository.getAllPromotions();
    }

    // Get promotion by ID
    public Promotion getPromotionById(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Promotion ID must be positive");
        }
        return promotionRepository.getPromotionById(id);
    }

    // Get active promotions (currently running)
    public List<Promotion> getActivePromotions() {
        return promotionRepository.getActivePromotions();
    }

    // Get upcoming promotions
    public List<Promotion> getUpcomingPromotions() {
        return promotionRepository.getUpcomingPromotions();
    }

    // Check if there's an active promotion right now
    public boolean hasActivePromotion() {
        List<Promotion> activePromotions = promotionRepository.getActivePromotions();
        return !activePromotions.isEmpty();
    }

    // Get the best active promotion (highest discount)
    public Promotion getBestActivePromotion() {
        List<Promotion> activePromotions = promotionRepository.getActivePromotions();

        if (activePromotions.isEmpty()) {
            return null;
        }

        Promotion bestPromo = activePromotions.get(0);
        for (Promotion promo : activePromotions) {
            if (promo.getPromotionValeur() > bestPromo.getPromotionValeur()) {
                bestPromo = promo;
            }
        }

        return bestPromo;
    }

    // Calculate discounted price
    public double calculateDiscountedPrice(double originalPrice, Promotion promotion) {
        if (originalPrice < 0) {
            throw new IllegalArgumentException("Price cannot be negative");
        }
        if (promotion == null) {
            return originalPrice;
        }

        double discount = originalPrice * (promotion.getPromotionValeur() / 100);
        return originalPrice - discount;
    }

    // Calculate discounted price with best active promotion
    public double calculateBestDiscountedPrice(double originalPrice) {
        Promotion bestPromo = getBestActivePromotion();
        return calculateDiscountedPrice(originalPrice, bestPromo);
    }

    // Add a new promotion
    public boolean addPromotion(Date dateDebut, Date dateFin, double valeur) {
        try {
            // Validation is done in Promotion constructor
            Promotion promotion = new Promotion(dateDebut, dateFin, valeur);
            return promotionRepository.addPromotion(promotion);
        } catch (IllegalArgumentException e) {
            System.err.println("Error adding promotion: " + e.getMessage());
            return false;
        }
    }

    // Add promotion with Promotion object
    public boolean addPromotion(Promotion promotion) {
        if (promotion == null) {
            throw new IllegalArgumentException("Promotion cannot be null");
        }
        return promotionRepository.addPromotion(promotion);
    }

    // Update a promotion
    public boolean updatePromotion(int id, Date dateDebut, Date dateFin, double valeur) {
        if (id <= 0) {
            throw new IllegalArgumentException("Promotion ID must be positive");
        }

        try {
            Promotion promotion = new Promotion(dateDebut, dateFin, valeur);
            return promotionRepository.updatePromotion(id, promotion);
        } catch (IllegalArgumentException e) {
            System.err.println("Error updating promotion: " + e.getMessage());
            return false;
        }
    }

    // Update promotion with Promotion object
    public boolean updatePromotion(int id, Promotion promotion) {
        if (id <= 0) {
            throw new IllegalArgumentException("Promotion ID must be positive");
        }
        if (promotion == null) {
            throw new IllegalArgumentException("Promotion cannot be null");
        }
        return promotionRepository.updatePromotion(id, promotion);
    }

    // Delete a promotion
    public boolean deletePromotion(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Promotion ID must be positive");
        }
        return promotionRepository.deletePromotion(id);
    }

    // Check if promotion is currently active
    public boolean isPromotionActive(Promotion promotion) {
        if (promotion == null) {
            return false;
        }

        Date now = new Date();
        return ! now.before(promotion.getDatePromotionDebut()) &&
                !now.after(promotion.getDatePromotionFin());
    }

    // Check if promotion is upcoming
    public boolean isPromotionUpcoming(Promotion promotion) {
        if (promotion == null) {
            return false;
        }

        Date now = new Date();
        return now.before(promotion.getDatePromotionDebut());
    }

    // Check if promotion is expired
    public boolean isPromotionExpired(Promotion promotion) {
        if (promotion == null) {
            return false;
        }

        Date now = new Date();
        return now.after(promotion.getDatePromotionFin());
    }

    // Get promotion status as string
    public String getPromotionStatus(Promotion promotion) {
        if (promotion == null) {
            return "Unknown";
        }

        if (isPromotionActive(promotion)) {
            return "Active";
        } else if (isPromotionUpcoming(promotion)) {
            return "Upcoming";
        } else if (isPromotionExpired(promotion)) {
            return "Expired";
        }

        return "Unknown";
    }

    // Count total promotions
    public int countAllPromotions() {
        return promotionRepository.getAllPromotions().size();
    }

    // Count active promotions
    public int countActivePromotions() {
        return promotionRepository.getActivePromotions().size();
    }

    // Count upcoming promotions
    public int countUpcomingPromotions() {
        return promotionRepository.getUpcomingPromotions().size();
    }
}