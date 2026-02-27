/// Contains an integer value that represents the value for number of concurrent
/// connections or the user sessions on your web app.
pub const WebAppUnits = union(enum) {
    /// An integer that represents the number of units for your desired number of
    /// concurrent connections, or the number of user sessions on your web app at
    /// the same time.
    ///
    /// Each increment allows an additional 250 concurrent sessions: a value of `1`
    /// sets the number of concurrent sessions to 250; `2` sets a value of 500, and
    /// so on.
    provisioned: ?i32,

    pub const json_field_names = .{
        .provisioned = "Provisioned",
    };
};
