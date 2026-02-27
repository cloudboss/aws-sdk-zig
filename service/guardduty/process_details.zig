const LineageObject = @import("lineage_object.zig").LineageObject;

/// Information about the observed process.
pub const ProcessDetails = struct {
    /// The effective user ID of the user that executed the process.
    euid: ?i32,

    /// The absolute path of the process executable file.
    executable_path: ?[]const u8,

    /// The `SHA256` hash of the process executable.
    executable_sha_256: ?[]const u8,

    /// Information about the process's lineage.
    lineage: ?[]const LineageObject,

    /// The name of the process.
    name: ?[]const u8,

    /// The ID of the child process.
    namespace_pid: ?i32,

    /// The unique ID of the parent process. This ID is assigned to the parent
    /// process by
    /// GuardDuty.
    parent_uuid: ?[]const u8,

    /// The ID of the process.
    pid: ?i32,

    /// The present working directory of the process.
    pwd: ?[]const u8,

    /// The time when the process started. This is in UTC format.
    start_time: ?i64,

    /// The user that executed the process.
    user: ?[]const u8,

    /// The unique ID of the user that executed the process.
    user_id: ?i32,

    /// The unique ID assigned to the process by GuardDuty.
    uuid: ?[]const u8,

    pub const json_field_names = .{
        .euid = "Euid",
        .executable_path = "ExecutablePath",
        .executable_sha_256 = "ExecutableSha256",
        .lineage = "Lineage",
        .name = "Name",
        .namespace_pid = "NamespacePid",
        .parent_uuid = "ParentUuid",
        .pid = "Pid",
        .pwd = "Pwd",
        .start_time = "StartTime",
        .user = "User",
        .user_id = "UserId",
        .uuid = "Uuid",
    };
};
