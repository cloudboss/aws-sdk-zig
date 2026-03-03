const AliasLifecycle = @import("alias_lifecycle.zig").AliasLifecycle;

/// A DNS alias that is associated with the file system. You can use a DNS alias
/// to access a file system using
/// user-defined DNS names, in addition to the default DNS name
/// that Amazon FSx assigns to the file system. For more information, see
/// [DNS
/// aliases](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-dns-aliases.html)
/// in the *FSx for Windows File Server User Guide*.
pub const Alias = struct {
    /// Describes the state of the DNS alias.
    ///
    /// * AVAILABLE - The DNS alias is associated with an Amazon FSx file system.
    ///
    /// * CREATING - Amazon FSx is creating the DNS alias and associating it with
    ///   the file system.
    ///
    /// * CREATE_FAILED - Amazon FSx was unable to associate the DNS alias with the
    ///   file system.
    ///
    /// * DELETING - Amazon FSx is disassociating the DNS alias from the file system
    ///   and deleting it.
    ///
    /// * DELETE_FAILED - Amazon FSx was unable to disassociate the DNS alias from
    ///   the file system.
    lifecycle: ?AliasLifecycle = null,

    /// The name of the DNS alias. The alias name has to meet the following
    /// requirements:
    ///
    /// * Formatted as a fully-qualified domain name (FQDN), `hostname.domain`, for
    ///   example, `accounting.example.com`.
    ///
    /// * Can contain alphanumeric characters, the underscore (_), and the hyphen
    ///   (-).
    ///
    /// * Cannot start or end with a hyphen.
    ///
    /// * Can start with a numeric.
    ///
    /// For DNS names, Amazon FSx stores alphabetic characters as lowercase letters
    /// (a-z), regardless of how you specify them:
    /// as uppercase letters, lowercase letters, or the corresponding letters in
    /// escape codes.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .lifecycle = "Lifecycle",
        .name = "Name",
    };
};
