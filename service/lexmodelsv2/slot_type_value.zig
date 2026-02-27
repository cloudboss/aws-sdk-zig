const SampleValue = @import("sample_value.zig").SampleValue;

/// Each slot type can have a set of values. Each
/// `SlotTypeValue` represents a value that the slot type can
/// take.
pub const SlotTypeValue = struct {
    /// The value of the slot type entry.
    sample_value: ?SampleValue,

    /// Additional values related to the slot type entry.
    synonyms: ?[]const SampleValue,

    pub const json_field_names = .{
        .sample_value = "sampleValue",
        .synonyms = "synonyms",
    };
};
