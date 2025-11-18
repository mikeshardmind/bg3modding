Things that aren't the mods themselves.


# priority_setter

Sets the priority on a pak file and all pak files within a zip file

# load_order_generator

Generates a load order from minimal sparse information.
Assumes valid data and no circular dependencies.

ordering is resolved using a combination of relations, and an affinity.
affinity is only used when multiple mods could theoretically go next.
lowest value is picked first.

It supports 3 relations:

requires: This is for listing hard requirements that should be loaded before.
patched_by: This is for listing mods that if present, should be loaded after.
patches: This is for listing mods that are patched by this. It's equivalent to patched_by but on the other side.

each of these supports using either the uuid or name

affinity is used to group mods within the loose order this creates. The default affinity is 50

This can be used to ensure certain mods that want to be loaded early or late (UI mods or compatability framework)
can be loaded generally where they want, and providing a best effort at keeping mods of the same type grouped.


# example_mod_data

Example expected format for the input file for the above generator.

For those familiar with toml,

It's expected as a series of tables, with a table name of the mod uuid.

Only name is required to be provided

```
[mod_uuid]
name = ""
affinity = 50
requires = []
patched_by = []
patches = []
```