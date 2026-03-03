const aws = @import("aws");

const ReservationAggregates = @import("reservation_aggregates.zig").ReservationAggregates;

/// A group of reservations that share a set of attributes.
pub const ReservationUtilizationGroup = struct {
    /// The attributes for this group of reservations.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The key for a specific reservation attribute.
    key: ?[]const u8 = null,

    /// How much you used this group of reservations.
    utilization: ?ReservationAggregates = null,

    /// The value of a specific reservation attribute.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .key = "Key",
        .utilization = "Utilization",
        .value = "Value",
    };
};
