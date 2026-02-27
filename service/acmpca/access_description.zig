const GeneralName = @import("general_name.zig").GeneralName;
const AccessMethod = @import("access_method.zig").AccessMethod;

/// Provides access information used by the `authorityInfoAccess` and
/// `subjectInfoAccess` extensions described in [RFC
/// 5280](https://datatracker.ietf.org/doc/html/rfc5280).
pub const AccessDescription = struct {
    /// The location of `AccessDescription` information.
    access_location: GeneralName,

    /// The type and format of `AccessDescription` information.
    access_method: AccessMethod,

    pub const json_field_names = .{
        .access_location = "AccessLocation",
        .access_method = "AccessMethod",
    };
};
