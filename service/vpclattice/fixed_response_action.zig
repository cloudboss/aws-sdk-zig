/// Describes an action that returns a custom HTTP response.
pub const FixedResponseAction = struct {
    /// The HTTP response code. Only `404` and `500` status codes are supported.
    status_code: i32,

    pub const json_field_names = .{
        .status_code = "statusCode",
    };
};
