const Target = @import("target.zig").Target;

/// A home region control is an object that specifies the home region for an
/// account, with
/// some additional information. It contains a target (always of type
/// `ACCOUNT`), an
/// ID, and a time at which the home region was set.
pub const HomeRegionControl = struct {
    /// A unique identifier that's generated for each home region control. It's
    /// always a string
    /// that begins with "hrc-" followed by 12 lowercase letters and numbers.
    control_id: ?[]const u8 = null,

    /// The AWS Region that's been set as home region. For example, "us-west-2" or
    /// "eu-central-1"
    /// are valid home regions.
    home_region: ?[]const u8 = null,

    /// A timestamp representing the time when the customer called
    /// `CreateHomeregionControl` and set the home region for the account.
    requested_time: ?i64 = null,

    /// The target parameter specifies the identifier to which the home region is
    /// applied, which
    /// is always an `ACCOUNT`. It applies the home region to the current
    /// `ACCOUNT`.
    target: ?Target = null,

    pub const json_field_names = .{
        .control_id = "ControlId",
        .home_region = "HomeRegion",
        .requested_time = "RequestedTime",
        .target = "Target",
    };
};
