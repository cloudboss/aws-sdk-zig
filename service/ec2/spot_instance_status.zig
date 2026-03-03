/// Describes the status of a Spot Instance request.
pub const SpotInstanceStatus = struct {
    /// The status code. For a list of status codes, see [Spot request status
    /// codes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-request-status.html#spot-instance-request-status-understand) in the *Amazon EC2 User Guide*.
    code: ?[]const u8 = null,

    /// The description for the status code.
    message: ?[]const u8 = null,

    /// The date and time of the most recent status update, in UTC format (for
    /// example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    update_time: ?i64 = null,
};
