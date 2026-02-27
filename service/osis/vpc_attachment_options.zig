/// Options for attaching a VPC to pipeline.
pub const VpcAttachmentOptions = struct {
    /// Whether a VPC is attached to the pipeline.
    attach_to_vpc: bool,

    /// The CIDR block to be reserved for OpenSearch Ingestion to create elastic
    /// network interfaces (ENIs).
    cidr_block: ?[]const u8,

    pub const json_field_names = .{
        .attach_to_vpc = "AttachToVpc",
        .cidr_block = "CidrBlock",
    };
};
