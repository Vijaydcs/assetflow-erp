package com.assetflow.controller;

import com.assetflow.model.Activity;
import com.assetflow.model.Asset;
import com.assetflow.model.DashboardResponse;

import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class DashboardController {

    @GetMapping("/dashboard")
    public DashboardResponse dashboard() {

        DashboardResponse response = new DashboardResponse();

        response.setTotalAssets(156);
        response.setAvailableAssets(63);
        response.setAllocatedAssets(72);
        response.setMaintenanceAssets(21);

        response.setAssets(List.of(

                new Asset(
                        "AF-0001",
                        "Dell Latitude 7440",
                        "Electronics",
                        "Engineering",
                        "Bengaluru HQ",
                        "Excellent",
                        "Allocated",
                        92
                ),

                new Asset(
                        "AF-0002",
                        "Sony Conference Camera",
                        "Electronics",
                        "Operations",
                        "Meeting Room B2",
                        "Good",
                        "Available",
                        96
                )

        ));

        response.setRecentActivities(List.of(

                new Activity("Laptop allocated to Heer"),

                new Activity("Maintenance completed"),

                new Activity("Projector returned")

        ));

        return response;
    }

}
