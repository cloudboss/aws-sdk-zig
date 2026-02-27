const StandardIdentifier = @import("standard_identifier.zig").StandardIdentifier;

/// An object that defines the Key element of a ProfileObject. A Key is a
/// special element
/// that can be used to search for a customer profile.
pub const ObjectTypeKey = struct {
    /// The reference for the key name of the fields map.
    field_names: ?[]const []const u8,

    /// The types of keys that a ProfileObject can have. Each ProfileObject can have
    /// only 1
    /// UNIQUE key but multiple PROFILE keys. PROFILE, ASSET, CASE, or ORDER means
    /// that this key
    /// can be used to tie an object to a PROFILE, ASSET, CASE, or ORDER
    /// respectively. UNIQUE means
    /// that it can be used to uniquely identify an object. If a key a is marked as
    /// SECONDARY, it
    /// will be used to search for profiles after all other PROFILE keys have been
    /// searched. A
    /// LOOKUP_ONLY key is only used to match a profile but is not persisted to be
    /// used for
    /// searching of the profile. A NEW_ONLY key is only used if the profile does
    /// not already exist
    /// before the object is ingested, otherwise it is only used for matching
    /// objects to
    /// profiles.
    standard_identifiers: ?[]const StandardIdentifier,

    pub const json_field_names = .{
        .field_names = "FieldNames",
        .standard_identifiers = "StandardIdentifiers",
    };
};
