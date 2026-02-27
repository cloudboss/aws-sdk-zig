const TimeUnitsType = @import("time_units_type.zig").TimeUnitsType;

/// The time units that, with `IdTokenValidity`,
/// `AccessTokenValidity`, and `RefreshTokenValidity`, set and
/// display the duration of ID, access, and refresh tokens for an app client.
/// You can assign
/// a separate token validity unit to each type of token.
pub const TokenValidityUnitsType = struct {
    /// A time unit for the value that you set in the `AccessTokenValidity`
    /// parameter. The default `AccessTokenValidity` time unit is `hours`.
    /// `AccessTokenValidity` duration can range from five minutes to one
    /// day.
    access_token: ?TimeUnitsType,

    /// A time unit for the value that you set in the `IdTokenValidity` parameter.
    /// The default `IdTokenValidity` time unit is `hours`.
    /// `IdTokenValidity` duration can range from five minutes to one day.
    id_token: ?TimeUnitsType,

    /// A time unit for the value that you set in the `RefreshTokenValidity`
    /// parameter. The default `RefreshTokenValidity` time unit is `days`.
    /// `RefreshTokenValidity` duration can range from 60 minutes to 10
    /// years.
    refresh_token: ?TimeUnitsType,

    pub const json_field_names = .{
        .access_token = "AccessToken",
        .id_token = "IdToken",
        .refresh_token = "RefreshToken",
    };
};
