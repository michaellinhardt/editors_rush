void	read_loop(char *delim_string, char **ptr, int op, char **doc)
{
	while(**ptr)
	{
		char	*tmp;
		chat	*tmp2;

		tmp = *ptr;
		while (**ptr && **ptr != '\n')
			(*ptr)++;
                if (**ptr == '\n')
			(*ptr)++;
		tmp = ft_strndup(tmp, *ptr - tmp);
		if (op == DLESSDASH)
			tmp = remove_tab(tmp);
		if (!ft_strcmp(delim_string, tmp))
			break;
        tmp2 = ft_strjoin(*doc, tmp);
		ff;
		fff
			;

		free(*doc);
		free(tmp);           
		*doc = tmp2;
	}
}
