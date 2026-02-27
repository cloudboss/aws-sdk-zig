/// Hls Discontinuity Tags
pub const HlsDiscontinuityTags = enum {
    insert,
    never_insert,

    pub const json_field_names = .{
        .insert = "INSERT",
        .never_insert = "NEVER_INSERT",
    };
};
