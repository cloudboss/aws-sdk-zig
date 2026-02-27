pub const PortfolioShareType = enum {
    imported,
    aws_servicecatalog,
    aws_organizations,

    pub const json_field_names = .{
        .imported = "IMPORTED",
        .aws_servicecatalog = "AWS_SERVICECATALOG",
        .aws_organizations = "AWS_ORGANIZATIONS",
    };
};
