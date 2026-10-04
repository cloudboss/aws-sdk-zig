/// Details about the EV charge at the current step.
pub const RouteChargeStepDetails = struct {
    /// Estimated vehicle battery charge before this step (in kWh).
    arrival_charge: ?f64 = null,

    /// Maximum charging power available to the vehicle.
    ///
    /// **Unit**: `KwH`
    consumable_power: ?f64 = null,

    /// Details that are specific to a Charge step.
    ///
    /// **Unit**: `KwH`
    desired_charge: ?f64 = null,

    pub const json_field_names = .{
        .arrival_charge = "ArrivalCharge",
        .consumable_power = "ConsumablePower",
        .desired_charge = "DesiredCharge",
    };
};
