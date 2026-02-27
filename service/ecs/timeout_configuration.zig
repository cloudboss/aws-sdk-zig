/// An object that represents the timeout configurations for Service Connect.
///
/// If `idleTimeout` is set to a time that is less than
/// `perRequestTimeout`, the connection will close when the
/// `idleTimeout` is reached and not the
/// `perRequestTimeout`.
pub const TimeoutConfiguration = struct {
    /// The amount of time in seconds a connection will stay active while idle. A
    /// value of
    /// `0` can be set to disable `idleTimeout`.
    ///
    /// The `idleTimeout` default for
    /// `HTTP`/`HTTP2`/`GRPC` is 5 minutes.
    ///
    /// The `idleTimeout` default for `TCP` is 1 hour.
    idle_timeout_seconds: ?i32,

    /// The amount of time waiting for the upstream to respond with a complete
    /// response per
    /// request. A value of `0` can be set to disable `perRequestTimeout`.
    /// `perRequestTimeout` can only be set if Service Connect
    /// `appProtocol` isn't `TCP`. Only `idleTimeout` is
    /// allowed for `TCP`
    /// `appProtocol`.
    per_request_timeout_seconds: ?i32,

    pub const json_field_names = .{
        .idle_timeout_seconds = "idleTimeoutSeconds",
        .per_request_timeout_seconds = "perRequestTimeoutSeconds",
    };
};
