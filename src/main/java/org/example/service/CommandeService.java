package org.example.service;

import org.example.model.Commande;
import org.example.model.CommandeItem;
import org.example.repository.CommandeRepository;

import java.util.List;

public class CommandeService {

    private final CommandeRepository commandeRepository;

    public CommandeService() {
        this.commandeRepository = new CommandeRepository();
    }

    /**
     * Create a new order
     */
    public Commande createCommande(Commande commande) {
        return commandeRepository.createCommande(commande);
    }

    /**
     * Get orders for a specific user by ID
     */
    public List<Commande> getCommandesByUserId(int userId) {
        return commandeRepository.getCommandesByUserId(userId);
    }

    /**
     * Get orders for a specific user by email
     */
    public List<Commande> getCommandesByUserEmail(String email) {
        return commandeRepository.getCommandesByUserEmail(email);
    }

    /**
     * Get all orders (for admin)
     */
    public List<Commande> getAllCommandes() {
        return commandeRepository.getAllCommandes();
    }

    /**
     * Get a single order by ID
     */
    public Commande getCommandeById(int id) {
        return commandeRepository.getCommandeById(id);
    }

    /**
     * Get items for a specific order
     */
    public List<CommandeItem> getCommandeItems(int commandeId) {
        return commandeRepository.getCommandeItems(commandeId);
    }

    /**
     * Update order status
     */
    public boolean updateCommandeStatus(int commandeId, String status) {
        return commandeRepository.updateCommandeStatus(commandeId, status);
    }

    /**
     * Count total orders
     */
    public int countCommandes() {
        return commandeRepository.countCommandes();
    }
}
