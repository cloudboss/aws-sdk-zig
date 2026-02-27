const AudienceSizeType = @import("audience_size_type.zig").AudienceSizeType;

/// The size of the generated audience. Must match one of the sizes in the
/// configured audience model.
pub const AudienceSize = struct {
    /// Whether the audience size is defined in absolute terms or as a percentage.
    /// You can use the `ABSOLUTE` AudienceSize to configure out audience sizes
    /// using the count of identifiers in the output. You can use the `Percentage`
    /// AudienceSize to configure sizes in the range 1-100 percent.
    @"type": AudienceSizeType,

    /// Specify an audience size value.
    value: i32,

    pub const json_field_names = .{
        .@"type" = "type",
        .value = "value",
    };
};
