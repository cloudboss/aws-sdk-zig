const AdditionalEnis = @import("additional_enis.zig").AdditionalEnis;

/// The customer ENI and additional ENIs associated with a network interface
/// category.
pub const InstanceRequirementsEniConfiguration = struct {
    /// Information about additional Elastic Network Interfaces (ENIs) associated
    /// with the instance type category.
    additional_enis: ?AdditionalEnis = null,

    /// The ID of the customer-managed Elastic Network Interface (ENI) associated
    /// with the instance type category.
    customer_eni: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_enis = "AdditionalEnis",
        .customer_eni = "CustomerEni",
    };
};
