/// Contains the Amazon Glacier response to your request.
pub const DescribeVaultOutput = struct {
    /// The Universal Coordinated Time (UTC) date when the vault was created. This
    /// value
    /// should be a string in the ISO 8601 date format, for example
    /// `2012-03-20T17:03:43.221Z`.
    creation_date: ?[]const u8 = null,

    /// The Universal Coordinated Time (UTC) date when Amazon Glacier completed the
    /// last
    /// vault inventory. This value should be a string in the ISO 8601 date format,
    /// for example
    /// `2012-03-20T17:03:43.221Z`.
    last_inventory_date: ?[]const u8 = null,

    /// The number of archives in the vault as of the last inventory date. This
    /// field will
    /// return `null` if an inventory has not yet run on the vault, for example if
    /// you
    /// just created the vault.
    number_of_archives: i64 = 0,

    /// Total size, in bytes, of the archives in the vault as of the last inventory
    /// date.
    /// This field will return null if an inventory has not yet run on the vault,
    /// for example if
    /// you just created the vault.
    size_in_bytes: i64 = 0,

    /// The Amazon Resource Name (ARN) of the vault.
    vault_arn: ?[]const u8 = null,

    /// The name of the vault.
    vault_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .last_inventory_date = "LastInventoryDate",
        .number_of_archives = "NumberOfArchives",
        .size_in_bytes = "SizeInBytes",
        .vault_arn = "VaultARN",
        .vault_name = "VaultName",
    };
};
