/// Specifies the user and group whose permissions are used when running the
/// Lambda function. You can specify one or both values to override the default
/// values. We recommend that you avoid running as root unless absolutely
/// necessary to minimize the risk of unintended changes or malicious attacks.
/// To run as root, you must set ''IsolationMode'' to ''NoContainer'' and update
/// config.json in ''greengrass-root/config'' to set
/// ''allowFunctionsToRunAsRoot'' to ''yes''.
pub const FunctionRunAsConfig = struct {
    /// The group ID whose permissions are used to run a Lambda function.
    gid: ?i32,

    /// The user ID whose permissions are used to run a Lambda function.
    uid: ?i32,

    pub const json_field_names = .{
        .gid = "Gid",
        .uid = "Uid",
    };
};
