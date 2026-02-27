pub const RedactionOutput = enum {
    redacted,
    redacted_and_unredacted,

    pub const json_field_names = .{
        .redacted = "REDACTED",
        .redacted_and_unredacted = "REDACTED_AND_UNREDACTED",
    };
};
