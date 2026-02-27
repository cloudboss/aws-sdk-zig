const LabelAlias = @import("label_alias.zig").LabelAlias;
const LabelCategory = @import("label_category.zig").LabelCategory;
const Instance = @import("instance.zig").Instance;
const Parent = @import("parent.zig").Parent;

/// Structure containing details about the detected label, including the name,
/// detected
/// instances, parent labels, and level of confidence.
pub const Label = struct {
    /// A list of potential aliases for a given label.
    aliases: ?[]const LabelAlias,

    /// A list of the categories associated with a given label.
    categories: ?[]const LabelCategory,

    /// Level of confidence.
    confidence: ?f32,

    /// If `Label` represents an object, `Instances` contains the bounding
    /// boxes for each instance of the detected object. Bounding boxes are returned
    /// for common object
    /// labels such as people, cars, furniture, apparel or pets.
    instances: ?[]const Instance,

    /// The name (label) of the object or scene.
    name: ?[]const u8,

    /// The parent labels for a label. The response includes all ancestor labels.
    parents: ?[]const Parent,

    pub const json_field_names = .{
        .aliases = "Aliases",
        .categories = "Categories",
        .confidence = "Confidence",
        .instances = "Instances",
        .name = "Name",
        .parents = "Parents",
    };
};
