package com.assetflow.model;

import java.util.List;

public class DashboardResponse {

    private int totalAssets;
    private int availableAssets;
    private int allocatedAssets;
    private int maintenanceAssets;

    private List<Activity> recentActivities;

    private List<Asset> assets;

    public DashboardResponse() {
    }

    public int getTotalAssets() {
        return totalAssets;
    }

    public void setTotalAssets(int totalAssets) {
        this.totalAssets = totalAssets;
    }

    public int getAvailableAssets() {
        return availableAssets;
    }

    public void setAvailableAssets(int availableAssets) {
        this.availableAssets = availableAssets;
    }

    public int getAllocatedAssets() {
        return allocatedAssets;
    }

    public void setAllocatedAssets(int allocatedAssets) {
        this.allocatedAssets = allocatedAssets;
    }

    public int getMaintenanceAssets() {
        return maintenanceAssets;
    }

    public void setMaintenanceAssets(int maintenanceAssets) {
        this.maintenanceAssets = maintenanceAssets;
    }

    public List<Activity> getRecentActivities() {
        return recentActivities;
    }

    public void setRecentActivities(List<Activity> recentActivities) {
        this.recentActivities = recentActivities;
    }

    public List<Asset> getAssets() {
        return assets;
    }

    public void setAssets(List<Asset> assets) {
        this.assets = assets;
    }
}
