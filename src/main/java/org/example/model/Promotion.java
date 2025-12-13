package org.example.model;

import java.util.Date;

public class Promotion
{
    private int id;
    private Date datePromotionDebut;
    private Date datePromotionFin;

    public Promotion( Date datePromotionDebut, Date datePromotionFin, double promotionValeur) {


        // il faut que less date n'est pas nulll
        if (datePromotionDebut == null || datePromotionFin == null) {
            throw new IllegalArgumentException("Promotion dates cannot be null");
        }
        // il faut que dateDebut < dateFin
        if (datePromotionFin.before(datePromotionDebut)) {
            throw new IllegalArgumentException("End date must be after start date");
        }
        // Validate promotion value
        if (promotionValeur < 0 || promotionValeur > 100) {
            throw new IllegalArgumentException("Promotion value must be between 0 and 100");
        }

        this.datePromotionDebut = datePromotionDebut;
        this.datePromotionFin = datePromotionFin;
        this.promotionValeur = promotionValeur;
    }

    public Date getDatePromotionDebut() {
        return datePromotionDebut;
    }

    public void setDatePromotionDebut(Date datePromotionDebut) {
        this.datePromotionDebut = datePromotionDebut;
    }

    public Date getDatePromotionFin() {
        return datePromotionFin;
    }

    public void setDatePromotionFin(Date datePromotionFin) {
        this.datePromotionFin = datePromotionFin;
    }

    public double getPromotionValeur() {
        return promotionValeur;
    }

    public void setPromotionValeur(double promotionValeur) {
        this.promotionValeur = promotionValeur;
    }

    private double promotionValeur;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
