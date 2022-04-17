# 获取pmid
esearch -db pubmed -query "covid-19" | efetch -format uid > covid_19_pmid.txt

# 通过PubTator API获取实体数据
echo 'I am curating the result.'
for pmid in $(cat covid_19_pmid.txt)
do
    echo ${pmid}
    curl https://www.ncbi.nlm.nih.gov/research/pubtator-api/publications/export/pubtator?pmids=${pmid} >> covid_19_annotation_result.txt
    sleep 3.1s
done

# 提取实体数据
grep -E "^[0-9]{8}\s" covid_19_annotation_result.txt > covid_19_entity_info.txt
# awk -F'\t' '{print $4}' covid_19_entity_info.txt > covid_19_entity_name.txt
# awk -F'\t' '{print $5}' covid_19_entity_info.txt > covid_19_entity_label.txt
# awk -F'\t' '{print $6}' covid_19_entity_info.txt > covid_19_entity_label_id.txt

# 提取摘要数据
grep -E "^[0-9]{8}\|a" covid_19_annotation_result.txt | sed -r "s/.{11}//" > covid_19_abstract.txt
sed -i '/^$/d' covid_19_abstract.txt

