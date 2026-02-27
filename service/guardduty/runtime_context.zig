const ProcessDetails = @import("process_details.zig").ProcessDetails;

/// Additional information about the suspicious activity.
pub const RuntimeContext = struct {
    /// Represents the communication protocol associated with the address. For
    /// example, the address
    /// family `AF_INET` is used for IP version of 4 protocol.
    address_family: ?[]const u8,

    /// Example of the command line involved in the suspicious activity.
    command_line_example: ?[]const u8,

    /// Represents the type of mounted fileSystem.
    file_system_type: ?[]const u8,

    /// Represents options that control the behavior of a runtime operation or
    /// action. For
    /// example, a filesystem mount operation may contain a read-only flag.
    flags: ?[]const []const u8,

    /// Specifies a particular protocol within the address family. Usually there is
    /// a single
    /// protocol in address families. For example, the address family `AF_INET` only
    /// has
    /// the IP protocol.
    iana_protocol_number: ?i32,

    /// The value of the LD_PRELOAD environment variable.
    ld_preload_value: ?[]const u8,

    /// The path to the new library that was loaded.
    library_path: ?[]const u8,

    /// Specifies the Region of a process's address space such as stack and heap.
    memory_regions: ?[]const []const u8,

    /// The timestamp at which the process modified the current process. The
    /// timestamp is in UTC date string
    /// format.
    modified_at: ?i64,

    /// Information about the process that modified the current process. This is
    /// available for
    /// multiple finding types.
    modifying_process: ?ProcessDetails,

    /// The path to the module loaded into the kernel.
    module_file_path: ?[]const u8,

    /// The name of the module loaded into the kernel.
    module_name: ?[]const u8,

    /// The `SHA256` hash of the module.
    module_sha_256: ?[]const u8,

    /// The path on the host that is mounted by the container.
    mount_source: ?[]const u8,

    /// The path in the container that is mapped to the host directory.
    mount_target: ?[]const u8,

    /// The path in the container that modified the release agent file.
    release_agent_path: ?[]const u8,

    /// The path to the leveraged `runc` implementation.
    runc_binary_path: ?[]const u8,

    /// The path to the script that was executed.
    script_path: ?[]const u8,

    /// Name of the security service that has been potentially disabled.
    service_name: ?[]const u8,

    /// The path to the modified shell history file.
    shell_history_file_path: ?[]const u8,

    /// The path to the docket socket that was accessed.
    socket_path: ?[]const u8,

    /// Information about the process that had its memory overwritten by the current
    /// process.
    target_process: ?ProcessDetails,

    /// The suspicious file path for which the threat intelligence details were
    /// found.
    threat_file_path: ?[]const u8,

    /// Category that the tool belongs to. Some of the examples
    /// are Backdoor Tool, Pentest Tool, Network Scanner, and Network Sniffer.
    tool_category: ?[]const u8,

    /// Name of the potentially suspicious tool.
    tool_name: ?[]const u8,

    pub const json_field_names = .{
        .address_family = "AddressFamily",
        .command_line_example = "CommandLineExample",
        .file_system_type = "FileSystemType",
        .flags = "Flags",
        .iana_protocol_number = "IanaProtocolNumber",
        .ld_preload_value = "LdPreloadValue",
        .library_path = "LibraryPath",
        .memory_regions = "MemoryRegions",
        .modified_at = "ModifiedAt",
        .modifying_process = "ModifyingProcess",
        .module_file_path = "ModuleFilePath",
        .module_name = "ModuleName",
        .module_sha_256 = "ModuleSha256",
        .mount_source = "MountSource",
        .mount_target = "MountTarget",
        .release_agent_path = "ReleaseAgentPath",
        .runc_binary_path = "RuncBinaryPath",
        .script_path = "ScriptPath",
        .service_name = "ServiceName",
        .shell_history_file_path = "ShellHistoryFilePath",
        .socket_path = "SocketPath",
        .target_process = "TargetProcess",
        .threat_file_path = "ThreatFilePath",
        .tool_category = "ToolCategory",
        .tool_name = "ToolName",
    };
};
