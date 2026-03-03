/// Automated backups of a DB instance replicated to another Amazon Web Services
/// Region. They consist of system backups, transaction logs, and database
/// instance properties.
pub const DBInstanceAutomatedBackupsReplication = struct {
    /// The Amazon Resource Name (ARN) of the replicated automated backups.
    db_instance_automated_backups_arn: ?[]const u8 = null,
};
