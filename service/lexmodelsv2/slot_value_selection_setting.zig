const AdvancedRecognitionSetting = @import("advanced_recognition_setting.zig").AdvancedRecognitionSetting;
const SlotValueRegexFilter = @import("slot_value_regex_filter.zig").SlotValueRegexFilter;
const SlotValueResolutionStrategy = @import("slot_value_resolution_strategy.zig").SlotValueResolutionStrategy;

/// Contains settings used by Amazon Lex to select a slot value.
pub const SlotValueSelectionSetting = struct {
    /// Provides settings that enable advanced recognition settings for slot
    /// values. You can use this to enable using slot values as a custom
    /// vocabulary for recognizing user utterances.
    advanced_recognition_setting: ?AdvancedRecognitionSetting = null,

    /// A regular expression used to validate the value of a slot.
    regex_filter: ?SlotValueRegexFilter = null,

    /// Determines the slot resolution strategy that Amazon Lex uses to
    /// return slot type values. The field can be set to one of the following
    /// values:
    ///
    /// * `ORIGINAL_VALUE` - Returns the value entered by the user, if the
    /// user value is similar to the slot value.
    ///
    /// * `TOP_RESOLUTION` - If there is a resolution list for the slot,
    /// return the first value in the resolution list as the slot type
    /// value. If there is no resolution list, null is returned.
    ///
    /// If you don't specify the `valueSelectionStrategy`, the
    /// default is `ORIGINAL_VALUE`.
    resolution_strategy: SlotValueResolutionStrategy,

    pub const json_field_names = .{
        .advanced_recognition_setting = "advancedRecognitionSetting",
        .regex_filter = "regexFilter",
        .resolution_strategy = "resolutionStrategy",
    };
};
