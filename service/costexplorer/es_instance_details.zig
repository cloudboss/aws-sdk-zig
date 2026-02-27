/// Details about the Amazon OpenSearch Service reservations that Amazon Web
/// Services
/// recommends that you purchase.
pub const ESInstanceDetails = struct {
    /// Determines whether the recommendation is for a current-generation instance.
    current_generation: bool = false,

    /// The class of instance that Amazon Web Services recommends.
    instance_class: ?[]const u8,

    /// The size of instance that Amazon Web Services recommends.
    instance_size: ?[]const u8,

    /// The Amazon Web Services Region of the recommended reservation.
    region: ?[]const u8,

    /// Determines whether the recommended reservation is size flexible.
    size_flex_eligible: bool = false,

    pub const json_field_names = .{
        .current_generation = "CurrentGeneration",
        .instance_class = "InstanceClass",
        .instance_size = "InstanceSize",
        .region = "Region",
        .size_flex_eligible = "SizeFlexEligible",
    };
};
