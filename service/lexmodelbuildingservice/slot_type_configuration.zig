const SlotTypeRegexConfiguration = @import("slot_type_regex_configuration.zig").SlotTypeRegexConfiguration;

/// Provides configuration information for a slot type.
pub const SlotTypeConfiguration = struct {
    /// A regular expression used to validate the value of a slot.
    regex_configuration: ?SlotTypeRegexConfiguration,

    pub const json_field_names = .{
        .regex_configuration = "regexConfiguration",
    };
};
