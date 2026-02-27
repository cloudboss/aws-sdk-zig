/// Summary information about the Application Association.
pub const ApplicationAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the Application.
    application_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Application Association.
    application_association_arn: ?[]const u8,

    /// The identifier for the client that is associated with the Application
    /// Association.
    client_id: ?[]const u8,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .application_association_arn = "ApplicationAssociationArn",
        .client_id = "ClientId",
    };
};
