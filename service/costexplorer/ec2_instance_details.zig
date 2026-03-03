/// Details about the Amazon EC2 reservations that Amazon Web Services
/// recommends that you
/// purchase.
pub const EC2InstanceDetails = struct {
    /// The Availability Zone of the recommended reservation.
    availability_zone: ?[]const u8 = null,

    /// Determines whether the recommendation is for a current-generation instance.
    current_generation: bool = false,

    /// The instance family of the recommended reservation.
    family: ?[]const u8 = null,

    /// The type of instance that Amazon Web Services recommends.
    instance_type: ?[]const u8 = null,

    /// The platform of the recommended reservation. The platform is the specific
    /// combination
    /// of operating system, license model, and software on an instance.
    platform: ?[]const u8 = null,

    /// The Amazon Web Services Region of the recommended reservation.
    region: ?[]const u8 = null,

    /// Determines whether the recommended reservation is size flexible.
    size_flex_eligible: bool = false,

    /// Determines whether the recommended reservation is dedicated or shared.
    tenancy: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .current_generation = "CurrentGeneration",
        .family = "Family",
        .instance_type = "InstanceType",
        .platform = "Platform",
        .region = "Region",
        .size_flex_eligible = "SizeFlexEligible",
        .tenancy = "Tenancy",
    };
};
