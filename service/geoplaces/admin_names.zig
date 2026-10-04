const TranslationName = @import("translation_name.zig").TranslationName;
const AdminNamesPreference = @import("admin_names_preference.zig").AdminNamesPreference;

/// The official administrative names for an address component, returned when
/// `AddressNamesMode` is set to `Administrative`.
pub const AdminNames = struct {
    /// A list of translation names for the administrative address component,
    /// including name variants and translations in available languages.
    names: []const TranslationName,

    /// Indicates the preference level of the administrative name. Valid values are
    /// `Primary` and `Alternative`.
    preference: ?AdminNamesPreference = null,

    pub const json_field_names = .{
        .names = "Names",
        .preference = "Preference",
    };
};
