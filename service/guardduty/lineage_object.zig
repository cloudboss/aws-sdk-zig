/// Information about the runtime process details.
pub const LineageObject = struct {
    /// The effective user ID that was used to execute the process.
    euid: ?i32 = null,

    /// The absolute path of the process executable file.
    executable_path: ?[]const u8 = null,

    /// The name of the process.
    name: ?[]const u8 = null,

    /// The process ID of the child process.
    namespace_pid: ?i32 = null,

    /// The unique ID of the parent process. This ID is assigned to the parent
    /// process by
    /// GuardDuty.
    parent_uuid: ?[]const u8 = null,

    /// The ID of the process.
    pid: ?i32 = null,

    /// The time when the process started. This is in UTC format.
    start_time: ?i64 = null,

    /// The user ID of the user that executed the process.
    user_id: ?i32 = null,

    /// The unique ID assigned to the process by GuardDuty.
    uuid: ?[]const u8 = null,

    pub const json_field_names = .{
        .euid = "Euid",
        .executable_path = "ExecutablePath",
        .name = "Name",
        .namespace_pid = "NamespacePid",
        .parent_uuid = "ParentUuid",
        .pid = "Pid",
        .start_time = "StartTime",
        .user_id = "UserId",
        .uuid = "Uuid",
    };
};
