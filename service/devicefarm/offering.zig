const DevicePlatform = @import("device_platform.zig").DevicePlatform;
const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;
const OfferingType = @import("offering_type.zig").OfferingType;

/// Represents the metadata of a device offering.
pub const Offering = struct {
    /// A string that describes the offering.
    description: ?[]const u8,

    /// The ID that corresponds to a device offering.
    id: ?[]const u8,

    /// The platform of the device (for example, `ANDROID` or `IOS`).
    platform: ?DevicePlatform,

    /// Specifies whether there are recurring charges for the offering.
    recurring_charges: ?[]const RecurringCharge,

    /// The type of offering (for example, `RECURRING`) for a device.
    type: ?OfferingType,

    pub const json_field_names = .{
        .description = "description",
        .id = "id",
        .platform = "platform",
        .recurring_charges = "recurringCharges",
        .type = "type",
    };
};
