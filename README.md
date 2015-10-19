vim-name_object_after_its_type
==============================

A vim editor plugin that can save some typing when naming an object in programming languages such as C++.

The plugin creates an insert mode mapping for ````uu```` to insert a name based on the preceding type name.

*An example:*

To enter "````SourceLocation source_location;````" type "````SourceLocationuu;````".

Type names can be "CamelCase", "camelCase" or "Starts_with_a_capital". Object names are "lower_case_words_separated_by_underscores".

Where there is only one instance of a class in a particular scope it may make sense to name the object after the name of its type instead of inventing some other name.

*Another example:*

To enter "````SpaceStation mars_space_station;````" type "````SpaceStationuu;<Ctrl-o>bmars_````".

Vundle or Pathogen can be used to install this plugin.
