/// Settings to specify the rendering of motion graphics into the video stream.
pub const MotionGraphicsActivateScheduleActionSettings = struct {
    /// Duration (in milliseconds) that motion graphics should render on to the
    /// video stream. Leaving out this property or setting to 0 will result in
    /// rendering continuing until a deactivate action is processed.
    duration: ?i64 = null,

    /// Key used to extract the password from EC2 Parameter store
    password_param: ?[]const u8 = null,

    /// URI of the HTML5 content to be rendered into the live stream.
    url: ?[]const u8 = null,

    /// Documentation update needed
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .duration = "Duration",
        .password_param = "PasswordParam",
        .url = "Url",
        .username = "Username",
    };
};
