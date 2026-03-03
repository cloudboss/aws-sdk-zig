const std = @import("std");

/// The filter key to use when listing reputation entities. This can be one of
/// the following:
///
/// * `ENTITY_TYPE` – Filter by entity type.
///
/// * `REPUTATION_IMPACT` – Filter by reputation impact level.
///
/// * `SENDING_STATUS` – Filter by aggregate sending status.
///
/// * `ENTITY_REFERENCE_PREFIX` – Filter by entity reference prefix.
pub const ReputationEntityFilterKey = enum {
    entity_type,
    reputation_impact,
    status,
    entity_reference_prefix,

    pub const json_field_names = .{
        .entity_type = "ENTITY_TYPE",
        .reputation_impact = "REPUTATION_IMPACT",
        .status = "SENDING_STATUS",
        .entity_reference_prefix = "ENTITY_REFERENCE_PREFIX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .entity_type => "ENTITY_TYPE",
            .reputation_impact => "REPUTATION_IMPACT",
            .status => "SENDING_STATUS",
            .entity_reference_prefix => "ENTITY_REFERENCE_PREFIX",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
