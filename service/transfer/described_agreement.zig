const CustomDirectoriesType = @import("custom_directories_type.zig").CustomDirectoriesType;
const EnforceMessageSigningType = @import("enforce_message_signing_type.zig").EnforceMessageSigningType;
const PreserveFilenameType = @import("preserve_filename_type.zig").PreserveFilenameType;
const AgreementStatusType = @import("agreement_status_type.zig").AgreementStatusType;
const Tag = @import("tag.zig").Tag;

/// Describes the properties of an agreement.
pub const DescribedAgreement = struct {
    /// Connectors are used to send files using either the AS2 or SFTP protocol. For
    /// the access role, provide the Amazon Resource Name (ARN) of the Identity and
    /// Access Management role to use.
    ///
    /// **For AS2 connectors**
    ///
    /// With AS2, you can send files by calling `StartFileTransfer` and specifying
    /// the file paths in the request parameter, `SendFilePaths`. We use the file’s
    /// parent directory (for example, for `--send-file-paths /bucket/dir/file.txt`,
    /// parent directory is `/bucket/dir/`) to temporarily store a processed AS2
    /// message file, store the MDN when we receive them from the partner, and write
    /// a final JSON file containing relevant metadata of the transmission. So, the
    /// `AccessRole` needs to provide read and write access to the parent directory
    /// of the file location used in the `StartFileTransfer` request. Additionally,
    /// you need to provide read and write access to the parent directory of the
    /// files that you intend to send with `StartFileTransfer`.
    ///
    /// If you are using Basic authentication for your AS2 connector, the access
    /// role requires the `secretsmanager:GetSecretValue` permission for the secret.
    /// If the secret is encrypted using a customer-managed key instead of the
    /// Amazon Web Services managed key in Secrets Manager, then the role also needs
    /// the `kms:Decrypt` permission for that key.
    ///
    /// **For SFTP connectors**
    ///
    /// Make sure that the access role provides read and write access to the parent
    /// directory of the file location that's used in the `StartFileTransfer`
    /// request. Additionally, make sure that the role provides
    /// `secretsmanager:GetSecretValue` permission to Secrets Manager.
    access_role: ?[]const u8,

    /// A unique identifier for the agreement. This identifier is returned when you
    /// create an agreement.
    agreement_id: ?[]const u8,

    /// The unique Amazon Resource Name (ARN) for the agreement.
    arn: []const u8,

    /// The landing directory (folder) for files that are transferred by using the
    /// AS2 protocol.
    base_directory: ?[]const u8,

    /// A `CustomDirectoriesType` structure. This structure specifies custom
    /// directories for storing various AS2 message files. You can specify
    /// directories for the following types of files.
    ///
    /// * Failed files
    /// * MDN files
    /// * Payload files
    /// * Status files
    /// * Temporary files
    custom_directories: ?CustomDirectoriesType,

    /// The name or short description that's used to identify the agreement.
    description: ?[]const u8,

    /// Determines whether or not unsigned messages from your trading partners will
    /// be accepted.
    ///
    /// * `ENABLED`: Transfer Family rejects unsigned messages from your trading
    ///   partner.
    /// * `DISABLED` (default value): Transfer Family accepts unsigned messages from
    ///   your trading partner.
    enforce_message_signing: ?EnforceMessageSigningType,

    /// A unique identifier for the AS2 local profile.
    local_profile_id: ?[]const u8,

    /// A unique identifier for the partner profile used in the agreement.
    partner_profile_id: ?[]const u8,

    /// Determines whether or not Transfer Family appends a unique string of
    /// characters to the end of the AS2 message payload filename when saving it.
    ///
    /// * `ENABLED`: the filename provided by your trading parter is preserved when
    ///   the file is saved.
    /// * `DISABLED` (default value): when Transfer Family saves the file, the
    ///   filename is adjusted, as described in [File names and
    ///   locations](https://docs.aws.amazon.com/transfer/latest/userguide/send-as2-messages.html#file-names-as2).
    preserve_filename: ?PreserveFilenameType,

    /// A system-assigned unique identifier for a server instance. This identifier
    /// indicates the specific server that the agreement uses.
    server_id: ?[]const u8,

    /// The current status of the agreement, either `ACTIVE` or `INACTIVE`.
    status: ?AgreementStatusType,

    /// Key-value pairs that can be used to group and search for agreements.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .access_role = "AccessRole",
        .agreement_id = "AgreementId",
        .arn = "Arn",
        .base_directory = "BaseDirectory",
        .custom_directories = "CustomDirectories",
        .description = "Description",
        .enforce_message_signing = "EnforceMessageSigning",
        .local_profile_id = "LocalProfileId",
        .partner_profile_id = "PartnerProfileId",
        .preserve_filename = "PreserveFilename",
        .server_id = "ServerId",
        .status = "Status",
        .tags = "Tags",
    };
};
