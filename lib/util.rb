class Util
    #Input:
    # => cad: texto a buscar con + y *
    # => sqlquery: sql con ? donde van cada una de las palabras en cad
    #Output:
    # => Texto formateado para realizar la consulta en base de datos
    # => Sample
    #           cad= "Mauro% + Marozzi * Maximo"
    #           sqlquery = "nombre like %?%"
    #           prepare_query(cad, sqlquery) => "((nombre like %Mauro\\%%) or (nombre like %Marozzi%)) and ((nombre like %Maximo%))"
    def self.prepare_query(cad, sqlquery)
        and_arr=cad.split('*')
        sqlorwhere=""
        sqlandwhere=""
        and_arr.each do |textand|
            or_arr = textand.split('+')
            sqlorwhere=""
            or_arr.each do |textor|
                #text_clean= textor.gsub(/\s+/, " ").gsub('%', '\%').gsub('_', '\_').gsub("'","\'").gsub('"','\"').strip
                text_clean=self.escape_sql_string(textor)
                if !text_clean.empty?
                     s=sqlquery.gsub('?',text_clean)
                     sqlorwhere += ' or ' unless sqlorwhere.blank?
                     sqlorwhere +='('+s+')'
                end
            end
            if !sqlorwhere.blank?
                sqlandwhere += " and " unless sqlandwhere.blank?
                sqlandwhere +='('+sqlorwhere+')'
            end
        end
        return sqlandwhere
    end

    #Input: string
    #Output: string
    #Def: Dado un string devuelve el mismo string con caracteres escapados para mysql
    def self.escape_sql_string (texto)
        if !texto.blank?
            texto.gsub(/\s+/, " ").gsub('%', '\%').gsub('_', '\_').gsub("'","\'").gsub('"','\"').strip
        else
            texto
        end

    end
end

