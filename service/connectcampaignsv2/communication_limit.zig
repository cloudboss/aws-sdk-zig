const CommunicationLimitTimeUnit = @import("communication_limit_time_unit.zig").CommunicationLimitTimeUnit;

/// Communication Limit
pub const CommunicationLimit = struct {
    /// The number of days to consider with regards to this limit.
    frequency: i32,

    /// Maximum number of contacts allowed for a given target within the given
    /// frequency.
    max_count_per_recipient: i32,

    unit: CommunicationLimitTimeUnit,

    pub const json_field_names = .{
        .frequency = "frequency",
        .max_count_per_recipient = "maxCountPerRecipient",
        .unit = "unit",
    };
};
