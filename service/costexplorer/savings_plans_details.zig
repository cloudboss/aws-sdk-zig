/// The attribute details on a specific Savings Plan.
pub const SavingsPlansDetails = struct {
    /// A group of instance types that Savings Plans applies to.
    instance_family: ?[]const u8 = null,

    /// The unique ID that's used to distinguish Savings Plans from one another.
    offering_id: ?[]const u8 = null,

    /// A collection of Amazon Web Services resources in a geographic area. Each
    /// Amazon Web Services Region is isolated and independent of the other Regions.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_family = "InstanceFamily",
        .offering_id = "OfferingId",
        .region = "Region",
    };
};
